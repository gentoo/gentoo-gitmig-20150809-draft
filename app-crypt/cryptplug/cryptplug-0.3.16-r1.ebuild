# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptplug/cryptplug-0.3.16-r1.ebuild,v 1.1 2004/08/08 03:19:52 dragonheart Exp $

inherit eutils

DESCRIPTION="GPG and S/MIME encryption plugins.  Use by KMail v1.5 (KDE 3.1) and Mutt"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/cryptplug/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE=""

RDEPEND="=app-crypt/gpgme-0.3.14-r1
	virtual/libc"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/cryptplug-0.3.16-64bit.dif
	epatch ${FILESDIR}/cryptplug-0.3.16-initialize-fix.diff
	epatch ${FILESDIR}/gpgme3.patch
}

src_compile() {
	autoconf || die "autoconfigure failed"
	econf || "configure failed"
	emake || "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
}
