# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mpd/cl-mpd-0.5.ebuild,v 1.1 2006/07/23 20:53:45 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CL-MPD is an FFI-free, Common Lisp interface to Music Player Daemon."
HOMEPAGE="http://common-lisp.net/project/cl-mpd/"
SRC_URI="ftp://common-lisp.net/pub/project/cl-mpd/cl-mpd_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

CLPACKAGE=mpd

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/${PN}_${PV}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc LICENSE README AUTHORS COPYING
	insinto /usr/share/doc/${PF}/data
	doins data/*
}
