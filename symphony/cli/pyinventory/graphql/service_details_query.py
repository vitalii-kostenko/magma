#!/usr/bin/env python3
# @generated AUTOGENERATED file. Do not Change!

from dataclasses import dataclass
from datetime import datetime
from gql.gql.datetime_utils import DATETIME_FIELD
from gql.gql.graphql_client import GraphqlClient
from functools import partial
from numbers import Number
from typing import Any, Callable, List, Mapping, Optional

from dataclasses_json import DataClassJsonMixin

from .property_fragment import PropertyFragment, QUERY as PropertyFragmentQuery
from gql.gql.enum_utils import enum_field
from .service_endpoint_role_enum import ServiceEndpointRole


@dataclass
class ServiceDetailsQuery(DataClassJsonMixin):
    @dataclass
    class ServiceDetailsQueryData(DataClassJsonMixin):
        @dataclass
        class Node(DataClassJsonMixin):
            @dataclass
            class Customer(DataClassJsonMixin):
                id: str
                name: str
                externalId: Optional[str] = None

            @dataclass
            class ServiceEndpoint(DataClassJsonMixin):
                @dataclass
                class EquipmentPort(DataClassJsonMixin):
                    @dataclass
                    class Property(PropertyFragment):
                        pass

                    @dataclass
                    class EquipmentPortDefinition(DataClassJsonMixin):
                        id: str
                        name: str

                    @dataclass
                    class Link(DataClassJsonMixin):
                        @dataclass
                        class Service(DataClassJsonMixin):
                            id: str

                        id: str
                        services: List[Service]

                    id: str
                    properties: List[Property]
                    definition: EquipmentPortDefinition
                    link: Optional[Link] = None

                id: str
                port: EquipmentPort
                role: ServiceEndpointRole = enum_field(ServiceEndpointRole)

            @dataclass
            class Link(DataClassJsonMixin):
                @dataclass
                class Service(DataClassJsonMixin):
                    id: str

                id: str
                services: List[Service]

            id: str
            name: str
            endpoints: List[ServiceEndpoint]
            links: List[Link]
            externalId: Optional[str] = None
            customer: Optional[Customer] = None

        service: Optional[Node] = None

    data: ServiceDetailsQueryData

    __QUERY__: str = PropertyFragmentQuery + """
    query ServiceDetailsQuery($id: ID!) {
  service: node(id: $id) {
    ... on Service {
      id
      name
      externalId
      customer {
        id
        name
        externalId
      }
      endpoints {
        id
        port {
          id
          properties {
            ...PropertyFragment
          }
          definition {
            id
            name
          }
          link {
            id
            services {
              id
            }
          }
        }
        role
      }
      links {
        id
        services {
          id
        }
      }
    }
  }
}

    """

    @classmethod
    # fmt: off
    def execute(cls, client: GraphqlClient, id: str) -> ServiceDetailsQueryData:
        # fmt: off
        variables = {"id": id}
        response_text = client.call(cls.__QUERY__, variables=variables)
        return cls.from_json(response_text).data
