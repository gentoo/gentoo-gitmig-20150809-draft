# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-0.9.9.002.ebuild,v 1.1 2005/04/10 03:22:42 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="core event abstraction layer and X abstraction layer (nice convenience library)"
HOMEPAGE="http://www.enlightenment.org/pages/ecore.html"

IUSE="X fbcon opengl"

DEPEND=">=x11-libs/evas-0.9.9
	virtual/x11
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
