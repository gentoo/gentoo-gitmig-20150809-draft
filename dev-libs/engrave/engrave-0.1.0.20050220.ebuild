# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/engrave/engrave-0.1.0.20050220.ebuild,v 1.1 2005/02/21 09:56:55 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="library for editing the contents of edje files"

DEPEND=">=x11-libs/ecore-1.0.0.20041226_pre7
	>=x11-libs/evas-1.0.0.20041226_pre13"
