# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rip-l/rip-l-0.4.ebuild,v 1.1 2005/01/15 11:19:09 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="RIP-L is a threaded CD audio ripper/encoder in Common Lisp"
HOMEPAGE="http://www.xach.com/rip-l/"
SRC_URI="http://www.xach.com/rip-l/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/sbcl
	media-sound/cdparanoia
	media-sound/vorbis-tools"

CLPACKAGE=rip-l

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

pkg_setup() {
	if ! sbcl --noinform --eval '(quit :unix-status #+sb-thread 0 #-sb-thread 1)'; then
		die 'You need a SBCL compiled with "threads" enabled in USE to use RIP-L.'
	fi
}

src_install() {
	common-lisp-install rip-l.asd *.lisp
	common-lisp-system-symlink
	dodoc ChangeLog README
}
