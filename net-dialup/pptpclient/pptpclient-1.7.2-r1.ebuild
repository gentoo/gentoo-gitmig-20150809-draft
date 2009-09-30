# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpclient/pptpclient-1.7.2-r1.ebuild,v 1.5 2009/09/30 22:15:33 mrness Exp $

EAPI="2"

inherit eutils

MY_P=${P/client}
MY_CMD=pptp-command-20050401

DESCRIPTION="Linux client for PPTP"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/pptpclient/${MY_P}.tar.gz
	mirror://gentoo/${MY_CMD}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ~ppc64 x86"
IUSE="tk"

DEPEND="net-dialup/ppp
	dev-lang/perl
	tk? ( dev-perl/perl-tk )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

RESTRICT="test" #make test is useless and vector_test.c is broken

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-process-name.patch
	epatch "${FILESDIR}"/${P}-ip-path.patch
}

src_compile() {
	emake OPTIMISE= DEBUG= CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dosbin pptp
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO USING
	dodoc Documentation/*
	dodir /etc/pptp.d

	# The current version of pptp-linux doesn't include the
	# RH-specific portions, so include them ourselves.
	insinto /etc/ppp
	doins options.pptp
	newsbin "${WORKDIR}/${MY_CMD}" pptp-command
	dosbin "${FILESDIR}/pptp_fe.pl"
	use tk && dosbin "${FILESDIR}/xpptp_fe.pl"
}
