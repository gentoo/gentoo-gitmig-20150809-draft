# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/examine/examine-0.0.1.20031129.ebuild,v 1.1 2003/11/30 01:06:22 vapier Exp $

inherit enlightenment

DESCRIPTION="configuration library for applications based on the EFL"

DEPEND=">=dev-libs/eet-0.9.0.20031115
	>=dev-db/edb-1.0.4.20031115
	>=x11-libs/ewl-0.0.3.20031115
	>=x11-libs/ecore-1.0.0.20031115_pre4
	sys-libs/readline"
