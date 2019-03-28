#!/bin/bash
string_to_upper() {
    # Usage: string_to_upper "string"
    printf '%s\n' "${1^^}"
}
string_to_upper "wer"
