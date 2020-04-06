// Code generated by go-swagger; DO NOT EDIT.

package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"encoding/json"

	strfmt "github.com/go-openapi/strfmt"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/swag"
	"github.com/go-openapi/validate"
)

// Gy gy
// swagger:model gy
type Gy struct {

	// init method
	// Enum: [1 2]
	InitMethod *uint32 `json:"init_method,omitempty"`

	// overwrite apn
	OverwriteApn string `json:"overwrite_apn,omitempty"`

	// server
	Server *DiameterClientConfigs `json:"server,omitempty"`
}

// Validate validates this gy
func (m *Gy) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateInitMethod(formats); err != nil {
		res = append(res, err)
	}

	if err := m.validateServer(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

var gyTypeInitMethodPropEnum []interface{}

func init() {
	var res []uint32
	if err := json.Unmarshal([]byte(`[1,2]`), &res); err != nil {
		panic(err)
	}
	for _, v := range res {
		gyTypeInitMethodPropEnum = append(gyTypeInitMethodPropEnum, v)
	}
}

// prop value enum
func (m *Gy) validateInitMethodEnum(path, location string, value uint32) error {
	if err := validate.Enum(path, location, value, gyTypeInitMethodPropEnum); err != nil {
		return err
	}
	return nil
}

func (m *Gy) validateInitMethod(formats strfmt.Registry) error {

	if swag.IsZero(m.InitMethod) { // not required
		return nil
	}

	// value enum
	if err := m.validateInitMethodEnum("init_method", "body", *m.InitMethod); err != nil {
		return err
	}

	return nil
}

func (m *Gy) validateServer(formats strfmt.Registry) error {

	if swag.IsZero(m.Server) { // not required
		return nil
	}

	if m.Server != nil {
		if err := m.Server.Validate(formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("server")
			}
			return err
		}
	}

	return nil
}

// MarshalBinary interface implementation
func (m *Gy) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *Gy) UnmarshalBinary(b []byte) error {
	var res Gy
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}
