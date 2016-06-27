#copyright @ Eko India Financial Service Pvt. Ltd.
class DajaxiceError(Exception):
    pass


class FunctionNotCallableError(DajaxiceError):
    pass


class DajaxiceImportError(DajaxiceError):
    pass
