# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/examine/examine-0.0.1.20041016.ebuild,v 1.1 2004/10/18 13:16:01 vapier Exp $

inherit enlightenment

DESCRIPTION="configuration library for applications based on the EFL"

DEPEND=">=dev-libs/eet-0.9.0
	>=dev-db/edb-1.0.5
	>=x11-libs/ewl-0.0.3.20031115
	>=x11-libs/ecore-1.0.0_pre7
	sys-libs/readline"
