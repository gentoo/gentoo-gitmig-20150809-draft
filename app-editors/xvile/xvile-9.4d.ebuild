# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xvile/xvile-9.4d.ebuild,v 1.1 2004/03/03 15:37:10 agriffis Exp $

IUSE="perl"

S=${WORKDIR}/vile-9.4
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://ftp.phred.org/pub/vile/vile-9.4.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4d.patch.gz"

HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

RDEPEND="perl? ( dev-lang/perl )
	virtual/x11
	=app-editors/vile-${PVR}"

DEPEND="${RDEPEND}
	sys-devel/flex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ia64"

src_unpack() {
	local p

	unpack vile-9.4.tgz
	cd ${S} || die "cd failed"

	for p in ${DISTDIR}/vile-${PV%[a-z]}[a-${P##*[0-9]}].patch.gz; do
		epatch ${p} || die "epatch failed"
	done
}

src_compile() {
	econf --with-ncurses --with-x \
		`use_with perl` || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	dobin xvile
	dodoc CHANGES* COPYING MANIFEST INSTALL README* doc/*
}
