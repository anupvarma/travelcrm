# -*-coding: utf-8 -*-
from zope.interface import implementer

from ..interfaces import (
    IResourceType,
)
from ..resources import (
    ResourceTypeBase,
)


@implementer(IResourceType)
class StructureResource(ResourceTypeBase):

    __name__ = 'structure'

    @classmethod
    def get_subaccount_factory(cls):
        return None