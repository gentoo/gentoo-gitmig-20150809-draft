# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpclient/pptpclient-1.3.1.ebuild,v 1.9 2005/02/12 09:23:54 mrness Exp $

MY_P=pptp-linux-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Linux client for PPTP"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://gentoo/pptp-command
	mirror://sourceforge/pptpclient/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 alpha"
IUSE="tcltk"

DEPEND="net-dialup/ppp
		dev-lang/perl
		tcltk? ( dev-perl/perl-tk )"

src_compile() {
	make || die "make failed"
}

src_install() {
	dosbin pptp
	dodoc AUTHORS COPYING ChangeLog DEVELOPERS NEWS README TODO USING
	dodoc Documentation/*
	dodoc Reference/*
	dodir /etc/pptp.d

	# The current version of pptp-linux doesn't include the
	# RH-specific portions, so include them ourselves.
	cd ${FILESDIR}
	insinto /etc/ppp
	doins options.pptp
	dosbin ${DISTDIR}/pptp-command pptp_fe.pl
	use tcltk && dosbin xpptp_fe.pl
}
