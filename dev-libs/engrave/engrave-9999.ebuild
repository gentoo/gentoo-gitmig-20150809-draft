# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/engrave/engrave-9999.ebuild,v 1.5 2005/04/10 20:37:15 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="library for editing the contents of edje files"

DEPEND=">=x11-libs/ecore-0.9.9
	>=x11-libs/evas-0.9.9"
