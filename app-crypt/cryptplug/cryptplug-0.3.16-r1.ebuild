# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptplug/cryptplug-0.3.16-r1.ebuild,v 1.13 2005/08/07 09:46:21 dragonheart Exp $

inherit eutils

DESCRIPTION="GPG and S/MIME encryption plugins.  Use by KMail v1.5 (KDE 3.1) and Mutt"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/alpha/cryptplug/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ppc64"
IUSE=""

RDEPEND="~app-crypt/gpgme-0.3.14
	virtual/libc"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/cryptplug-0.3.16-64bit.dif
	epatch ${FILESDIR}/cryptplug-0.3.16-initialize-fix.diff
}

src_compile() {
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
}
