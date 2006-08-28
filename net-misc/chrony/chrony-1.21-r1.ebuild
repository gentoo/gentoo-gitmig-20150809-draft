# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.21-r1.ebuild,v 1.3 2006/08/28 21:53:35 jer Exp $

inherit eutils toolchain-funcs

PATCH_VER=1
PATCHDIR="${WORKDIR}/patch"

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.sunsite.dk/"
SRC_URI="http://chrony.sunsite.dk/download/${P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="readline"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A} ; cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.20-conf.c-gentoo.diff
	epatch "${FILESDIR}"/${PN}-1.20-chrony.conf.example-gentoo.diff
	epatch "${FILESDIR}"/${P}-makefile.diff

	# patches from chrony git repo: <http://chrony.sunsite.dk/git>
	EPATCH_MULTI_MSG="Applying patches from upstream..." \
	EPATCH_EXCLUDE="chrony-1.21-quash_compile_warnings.diff" \
	EPATCH_FORCE="yes" \
	EPATCH_SUFFIX="diff" epatch "${PATCHDIR}"

	# Allow Hz=200 detection (#21058, Alexander Papaspyrou)
#	epatch "${FILESDIR}"/${PN}-1.20-sys_linux.c-gentoo.diff

	sed -i "s:#if defined(__i386__) || defined(__sh__):& || defined(__x86_64__):" \
		io_linux.h || die "amd64 fix"
	sed -i "s:/etc/chrony:/etc/chrony/chrony:g" \
		chrony*.{1,5,8} faq.txt chrony.texi || die "sed failed"
	epatch "${FILESDIR}"/${P}-hppa.patch
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

	newinitd "${FILESDIR}"/chronyd.rc chronyd || die "newinitd failed"
	dosed "s:the documentation directory:/usr/share/doc/${PF}/:" \
		/etc/init.d/chronyd || die "doc sed failed"
	newconfd "${FILESDIR}"/chronyd.conf chronyd || die "newconfd failed"

	keepdir /var/{lib,log}/chrony /etc/chrony
}
