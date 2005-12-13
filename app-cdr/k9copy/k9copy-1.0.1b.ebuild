# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.0.1b.ebuild,v 1.1 2005/12/13 01:46:46 metalgod Exp $

inherit kde
need-kde 3.3

DESCRIPTION="k9copy is a DVD backup utility which allow the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.free.fr/"
SRC_URI="http://k9copy.free.fr/${PN}-1.0.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arts"
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	app-cdr/dvd+rw-tools
	app-cdr/k3b"

DOC="README TODO ChangeLog"
