# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.21.ebuild,v 1.2 2006/04/23 20:55:57 tove Exp $

inherit eutils toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.sunsite.dk/"
SRC_URI="http://chrony.sunsite.dk/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~mips ~ppc ~sparc ~x86"
IUSE="readline"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A} ; cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.20-conf.c-gentoo.diff
	epatch "${FILESDIR}"/${PN}-1.20-chrony.conf.example-gentoo.diff
	epatch "${FILESDIR}"/${P}-addrfilt.c.diff
	epatch "${FILESDIR}"/${P}-io_linux.h.diff

	# Allow Hz=200 detection (#21058, Alexander Papaspyrou)
#	epatch "${FILESDIR}"/${PN}-1.20-sys_linux.c-gentoo.diff

	sed -i "s:/etc/chrony:/etc/chrony/chrony:g" \
		chrony.conf.5 faq.txt chrony.texi || die "sed failed"
}

src_compile() {
	export CC="$(tc-getCC)"
	econf $(use_enable readline) || die "configure failed"
	emake all || die "make failed"
	emake docs || die "make docs failed"
}

src_install() {
	dobin chronyc || die "dobin failed"
	dosbin chronyd || die "dosbin failed"

	dodoc chrony.txt README examples/chrony.{conf,keys}.example || die "dodoc failed"
	dohtml chrony.html || die "dohtml failed"
	doman *.{1,5,8}
	doinfo chrony.info*

	exeinto /etc/init.d
	newexe "${FILESDIR}"/chronyd.rc chronyd || die "newexe failed"
	insinto /etc/conf.d
	newins "${FILESDIR}"/chronyd.conf chronyd || die "newins failed"
	dosed "s:the documentation directory:/usr/share/doc/${PF}/:" /etc/init.d/chronyd

	keepdir /var/{lib,log}/chrony /etc/chrony
}
