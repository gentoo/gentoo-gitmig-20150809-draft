# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.4d.ebuild,v 1.1 2004/01/11 04:57:07 agriffis Exp $

IUSE="perl"

S=${WORKDIR}/vile-9.4
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://ftp.phred.org/pub/vile/vile-9.4.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4d.patch.gz"

HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND="${RDEPEND}
	sys-devel/flex"

RDEPEND=">=sys-libs/ncurses-5.2
	perl? ( dev-lang/perl )"

PROVIDE="virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_unpack() {
	local p

	unpack vile-9.4.tgz
	cd ${S}

	for p in ${DISTDIR}/${P%[a-z]}[a-${P##*[0-9]}].patch.gz; do
		epatch ${p} || die "epatch failed"
	done
}

src_compile() {
	econf --with-ncurses \
		`use_with perl` || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	dodoc CHANGES* COPYING MANIFEST INSTALL README* doc/*
}

