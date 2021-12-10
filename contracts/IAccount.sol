// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IAccount {
    struct Account {
        string userName;
        uint256 createTime;
        bytes32[] postIds;
        bytes32[] commentIds;
        uint256 rank;
        Friend[] friends;
        bool isInitialized;
    }

    struct Friend {
        uint256 connectedTime;
        address friendAddress;
    }

    struct Post {
        uint256 postNumber;
        address ownerAddress;
        uint256 createTime;
        string postTitle;
        string postContent;
        bool isInitialized;
    }

    struct Comment {
        bytes32 postId;
        address ownerAddress;
        uint256 createTime;
        string commentContent;
        bool isInitialized;
    }

    event CreateAccountEvent(string);
    event PublishPostEvent(string);
    event CommentEvent(string);
}
