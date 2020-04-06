#!/usr/bin/env python3
# @generated AUTOGENERATED file. Do not Change!

from enum import Enum

class SurveyQuestionType(Enum):
    BOOL = "BOOL"
    EMAIL = "EMAIL"
    COORDS = "COORDS"
    PHONE = "PHONE"
    TEXT = "TEXT"
    TEXTAREA = "TEXTAREA"
    PHOTO = "PHOTO"
    WIFI = "WIFI"
    CELLULAR = "CELLULAR"
    FLOAT = "FLOAT"
    INTEGER = "INTEGER"
    DATE = "DATE"
    MISSING_ENUM = ""

    @classmethod
    def _missing_(cls, value: str) -> "SurveyQuestionType":
        return cls.MISSING_ENUM
