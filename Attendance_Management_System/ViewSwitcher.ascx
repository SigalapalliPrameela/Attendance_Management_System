<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewSwitcher.ascx.cs" Inherits="Attendance_Management_System.ViewSwitcher" %>

<style>
    .ams-view-switcher {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-wrap: wrap;
        gap: 6px;
        padding: 10px 14px;
        background-color: #f4f6f9;
        border: 1px solid #e1e6ed;
        border-radius: 6px;
        color: #667386;
        font-family: "Segoe UI", Arial, sans-serif;
        font-size: 13px;
    }

    .ams-view-switcher .current-view {
        color: #34465a;
        font-weight: 600;
    }

    .ams-view-switcher a {
        color: #315f91;
        font-weight: 600;
        text-decoration: none;
    }

    .ams-view-switcher a:hover {
        color: #244b75;
        text-decoration: underline;
    }

    .ams-view-switcher a:focus {
        outline: 2px solid #8bb7e5;
        outline-offset: 3px;
    }
</style>

<div id="viewSwitcher" class="ams-view-switcher">
    <span class="current-view"><%: CurrentView %> view</span>
    <span aria-hidden="true">|</span>
    <a href="<%: SwitchUrl %>" data-ajax="false">Switch to <%: AlternateView %></a>
</div>