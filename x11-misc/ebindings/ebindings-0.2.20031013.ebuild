# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ebindings/ebindings-0.2.20031013.ebuild,v 1.2 2004/04/05 22:09:04 vapier Exp $

inherit enlightenment

DESCRIPTION="e17 keybinding and menu editor"

DEPEND="virtual/x11
	>=x11-libs/evas-1.0.0.20030906_pre11
	>=dev-db/edb-1.0.4.20030906
	>=media-libs/ebits-1.0.1.20031013
	=x11-libs/gtk+-1*"
