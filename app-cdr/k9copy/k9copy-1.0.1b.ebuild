# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.0.1b.ebuild,v 1.2 2006/01/07 19:27:37 carlo Exp $

inherit kde

DESCRIPTION="k9copy is a DVD backup utility which allow the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.free.fr/"
SRC_URI="http://k9copy.free.fr/${PN}-1.0.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	app-cdr/dvd+rw-tools
	app-cdr/k3b"
need-kde 3.3

DOC="README TODO ChangeLog"
