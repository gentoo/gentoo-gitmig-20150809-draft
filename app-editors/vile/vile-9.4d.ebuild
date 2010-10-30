# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.4d.ebuild,v 1.13 2010/10/30 10:02:56 ssuominen Exp $

inherit eutils

S=${WORKDIR}/vile-9.4
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"
SRC_URI="ftp://ftp.phred.org/pub/vile/vile-9.4.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4d.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="perl"

RDEPEND=">=sys-libs/ncurses-5.2
	perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_unpack() {
	unpack vile-9.4.tgz
	cd "${S}"

	local p
	for p in "${DISTDIR}"/${P%[a-z]}[a-${P##*[0-9]}].patch.gz; do
		epatch ${p}
	done
}

src_compile() {
	econf \
		--with-ncurses \
		`use_with perl` \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc CHANGES* INSTALL README* doc/*
}
