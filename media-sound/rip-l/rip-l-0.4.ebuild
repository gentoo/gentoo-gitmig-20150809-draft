# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rip-l/rip-l-0.4.ebuild,v 1.2 2009/08/03 13:15:45 ssuominen Exp $

inherit common-lisp eutils

DESCRIPTION="RIP-L is a threaded CD audio ripper/encoder in Common Lisp"
HOMEPAGE="http://www.xach.com/rip-l/"
SRC_URI="http://www.xach.com/rip-l/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lisp/common-lisp-controller
	dev-lisp/sbcl
	media-sound/cdparanoia
	media-sound/vorbis-tools"
DEPEND="${RDEPEND}"

CLPACKAGE=rip-l

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-gentoo.patch
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
