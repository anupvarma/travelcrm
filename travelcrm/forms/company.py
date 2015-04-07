# -*-coding: utf-8 -*-

import colander

from . import (
    ResourceSchema,
    BaseForm,
)

from ..models.company import Company
from ..resources.company import CompanyResource


class _CompanySchema(ResourceSchema):
    email = colander.SchemaNode(
        colander.String(),
        validator=colander.All(colander.Email(), colander.Length(max=32))
    )
    name = colander.SchemaNode(
        colander.String(),
        validator=colander.All(colander.Length(max=32))
    )
    timezone = colander.SchemaNode(
        colander.String(),
    )
    locale = colander.SchemaNode(
        colander.String(),
    )
    currency_id = colander.SchemaNode(
        colander.Integer()
    )


class CompanyForm(BaseForm):
    _schema = _CompanySchema

    def submit(self, company=None):
        context = CompanyResource(self.request)
        if not company:
            company = Company(
                resource=context.create_resource()
            )
        company.name = self._controls.get('name')
        company.email = self._controls.get('email')
        company.currency_id = self._controls.get('currency_id')
        company.settings = {
            'timezone': self._controls.get('timezone'),
            'locale': self._controls.get('locale')
        }
        return company