# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-0.9.9.013.ebuild,v 1.2 2006/04/11 01:52:22 vapier Exp $

inherit enlightenment

DESCRIPTION="core event abstraction layer and X abstraction layer (nice convenience library)"

IUSE="X fbcon opengl"

DEPEND=">=x11-libs/evas-0.9.9
	|| ( x11-libs/libXcursor virtual/x11 )
	opengl? ( virtual/opengl )"

src_compile() {
	export MY_ECONF="
		$(use_enable X ecore-x) \
		--enable-ecore-job \
		$(use_enable fbcon ecore-fb) \
		--enable-ecore-evas \
		$(use_enable opengl ecore-evas-gl) \
		$(use_enable fbcon ecore-evas-fb) \
		--enable-ecore-con \
		--enable-ecore-ipc \
		--enable-ecore-txt \
		--enable-ecore-config
	"
	enlightenment_src_compile
}
