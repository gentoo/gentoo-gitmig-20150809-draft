# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/equate/equate-9999.ebuild,v 1.2 2004/10/22 12:42:16 vapier Exp $

ECVS_MODULE="misc/equate"
inherit enlightenment

DESCRIPTION="simple themeable calculator built off of ewl"
HOMEPAGE="http://andy.elcock.org/Software/Equate.xml"

DEPEND=">=x11-libs/ewl-0.0.3.20040103
	>=x11-libs/ecore-1.0.0_pre7"
