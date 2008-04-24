# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.23.ebuild,v 1.5 2008/04/24 06:58:39 tove Exp $

inherit eutils toolchain-funcs

MY_P=${P/_pre/-pre}
S=${WORKDIR}/${MY_P}

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.sunsite.dk/"
SRC_URI="http://chrony.sunsite.dk/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ~mips ppc sparc x86"
IUSE="readline"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A} ; cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.20-conf.c-gentoo.diff
	epatch "${FILESDIR}"/${PN}-1.20-chrony.conf.example-gentoo.diff
	epatch "${FILESDIR}"/${PN}-1.21-makefile.diff
	epatch "${FILESDIR}"/${P}-sources.diff

	sed -i "s:/etc/chrony:/etc/chrony/chrony:g" \
		chrony*.{1,5,8} faq.txt chrony.texi || die "sed failed"

	# bug 214757
	sed -i "s:defined(__ppc__) ||:& defined(__powerpc__) ||:" \
		"${S}"/io_linux.h || die

	epatch "${FILESDIR}"/${PN}-1.21-hppa.patch
}

src_compile() {
	tc-export CC
	local myconf
	# selfwritten configure
	use readline || myconf="--disable-readline"
	./configure --prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			${myconf} ${EXTRA_ECONF} || die "configure failed"
	emake all || die "make failed"
	emake docs || die "make docs failed"
}

src_install() {
	dobin chronyc || die
	dosbin chronyd || die

	dodoc chrony.txt README examples/chrony.{conf,keys}.example || die
	dohtml chrony.html || die
	doman *.{1,5,8}
	doinfo chrony.info*

	newinitd "${FILESDIR}"/chronyd.rc chronyd || die
	dosed "s:the documentation directory:/usr/share/doc/${PF}/:" \
		/etc/init.d/chronyd || die "doc sed failed"
	newconfd "${FILESDIR}"/chronyd.conf chronyd || die

	keepdir /var/{lib,log}/chrony /etc/chrony
}
