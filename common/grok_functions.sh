#!/bin/bash

function grok()
{
    "$HOME"/grok-port -q "$@"
}

function cgrok()
{
    "$HOME"/grok-port -q "$@" -t "c"
}

function cpgrok()
{
    "$HOME"/grok-port -q "$@" -t "c++"
}

function agrok()
{
    "$HOME"/grok-port -q "$@"
}

function jgrok()
{
    "$HOME"/grok-port -q "$@" -t "java"
}

function xgrok()
{
    "$HOME"/grok-port -q "$@" -t "XML"
}
