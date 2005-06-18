# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-9999.ebuild,v 1.8 2005/06/18 01:23:14 vapier Exp $

inherit enlightenment

DESCRIPTION="core event abstraction layer and X abstraction layer (nice convenience library)"

IUSE="X fbcon opengl ssl curl"

DEPEND=">=x11-libs/evas-0.9.9
	virtual/x11
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )
	opengl? ( virtual/opengl )"

src_compile() {
	export MY_ECONF="
		$(use_enable X ecore-x)
		--enable-ecore-job
		$(use_enable fbcon ecore-fb)
		--enable-ecore-evas
		$(use_enable opengl ecore-evas-gl)
		$(use_enable fbcon ecore-evas-fb)
		--enable-ecore-con
		--enable-ecore-ipc
		--enable-ecore-txt
		--enable-ecore-config
		$(use_with curl curl-config)
		$(use_enable ssl openssl)
	"
	enlightenment_src_compile
}
