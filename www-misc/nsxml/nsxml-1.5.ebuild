# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/nsxml/nsxml-1.5.ebuild,v 1.1 2005/01/05 14:46:16 port001 Exp $

inherit aolserver

IUSE="xslt"

DESCRIPTION="XML and XSLT processing capabilities for AOLServer"
HOMEPAGE="http://acs-misc.sourceforge.net/nsxml.html"

LICENSE="LGPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/libxml2
	xslt? ( dev-libs/libxslt )"
