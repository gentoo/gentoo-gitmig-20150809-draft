# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/nsxml/nsxml-1.5.ebuild,v 1.2 2005/02/12 02:51:43 port001 Exp $

inherit aolserver

IUSE="xslt"

DESCRIPTION="XML and XSLT processing capabilities for AOLServer"
HOMEPAGE="http://acs-misc.sourceforge.net/nsxml.html"

LICENSE="LGPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/libxml2
	xslt? ( dev-libs/libxslt )"

pkg_setup() {

	if use xslt; then
		MAKE_FLAGS="LIBXML2='/usr/' LIBXSLT='/usr/'"
	else
		MAKE_FLAGS="LIBXML2='/usr/'"
	fi
}
