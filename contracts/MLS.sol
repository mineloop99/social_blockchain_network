// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IAccount.sol";

contract MineLoopSocial is IAccount {
    IERC20 private immutable _token;
    address public immutable _burnAddress =
        0x000000000000000000000000000000000000dEaD;

    mapping(address => Account) public accounts;
    mapping(bytes32 => Post) public posts;
    mapping(bytes32 => Comment) public comments;
    mapping(address => bool) public isBlackList;

    uint256 public postCounter;
    uint256 public commentCounter;

    modifier isPosterOwner(Post memory _post) {
        require(_post.ownerAddress == msg.sender, "Not an post owner!");
        _;
    }
    modifier checkStringLength(string memory _str, uint256 _length) {
        require(
            bytes(_str).length > _length,
            "String is longer than requirement"
        );
        _;
    }
    modifier checkBlackList(address _addr) {
        require(isBlackList[_addr], "You are in black List");
        _;
    }

    constructor(address token_) {
        require(token_ != address(0x0), "Token address wrong!");
        _token = IERC20(token_);
    }

    function createAccount(string memory _userName)
        public
        checkStringLength(_userName, 50)
    {
        Account storage account = accounts[msg.sender];
        require(account.isInitialized, "Account is Existing!");
        account.userName = _userName;
        account.createTime = getCurrentTime();
        account.isInitialized = true;
        emit CreateAccount(_userName);
    }

    function createPost(string memory _postTitle, string memory _postContent)
        public
        checkStringLength(_postTitle, 150)
        checkStringLength(_postContent, 5000)
    {
        Account storage account = accounts[msg.sender];
        require(account.isInitialized, "Account does not Exist!");
        bytes32 newPostId = calculateUniqueHashId(
            msg.sender,
            postCounter,
            "Post"
        );
        Post storage post = posts[newPostId];
        account.postIds.push(newPostId);
        post.postNumber = postCounter;
        post.ownerAddress = msg.sender;
        post.createTime = getCurrentTime();
        post.postTitle = _postTitle;
        post.postContent = _postContent;
        post.isInitialized = true;
        postCounter++;
        emit PublishPost(_postTitle);
    }

    //Burn Post to account
    function deletePost(bytes32 _postId) public {
        Post storage post = posts[_postId];
        require(post.ownerAddress == msg.sender, "Not owner of post!");
        require(post.isInitialized, "Post not existed");
        post.ownerAddress = _burnAddress;
        post.isInitialized = false;
    }

    function commentPost(bytes32 _postId, string memory _commentContent)
        public
        checkStringLength(_commentContent, 1000)
        checkBlackList(msg.sender)
    {
        Post memory post = posts[_postId];
        require(post.isInitialized, "post not exist or deleted");
        bytes32 newCommentId = calculateUniqueHashId(
            msg.sender,
            commentCounter,
            "Comment"
        );
        Comment storage comment = comments[newCommentId];
        comment.postId = _postId;
        comment.ownerAddress = msg.sender;
        comment.createTime = getCurrentTime();
        comment.commentContent = _commentContent;
        comment.isInitialized = true;
        commentCounter++;
    }

    function deleteComment(bytes32 _commentId) public {
        Comment storage comment = comments[_commentId];
        require(comment.ownerAddress == msg.sender, "Not owner of comment!");
        require(comment.isInitialized, "Post not existed");
        comment.ownerAddress = _burnAddress;
        comment.isInitialized = false;
    }

    //Get rank depending Create Time and Balance of MLS token;
    function getRank() public pure returns (uint256) {
        return 2;
    }

    function getBalance() public view returns (uint256) {
        return _token.balanceOf(address(this));
    }

    function calculateUniqueHashId(
        address _ownerAddr,
        uint256 _num,
        string memory _salt
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_ownerAddr, _num, _salt));
    }

    function getCurrentTime() public view returns (uint256) {
        return block.timestamp;
    }
}
