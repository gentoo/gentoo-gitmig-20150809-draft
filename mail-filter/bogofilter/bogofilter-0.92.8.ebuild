# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.92.8.ebuild,v 1.3 2004/10/30 14:44:02 pylon Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="doc"

RDEPEND="virtual/libc
	>=sys-libs/db-3.2"
DEPEND="${DEPEND}
	!ppc64? ( doc? ( app-text/xmlto ) )"

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/share/${PN}/contrib
	doexe contrib/{bogofilter-qfe,bogogrep,mime.get.rfc822,parmtest.sh}
	doexe contrib/{randomtrain,scramble,*.pl}

	insinto /usr/share/${PN}/contrib
	doins contrib/{README.*,bogo.R,bogogrep.c,dot-qmail-bogofilter-default}
	doins contrib/{trainbogo.sh,*.example}

	dodoc AUTHORS CHANGES* COPYING INSTALL NEWS README
	dodoc RELEASE.NOTES* TODO doc/integrating-with-*

	dodir /usr/share/doc/${PF}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	#if xmlto is installed, html docu is gernerated automatically
	#if xmlto is not installed, there is still a html faq
	if use doc; then
		dohtml doc/*.html
	else
		dohtml doc/bogofilter-faq{,-fr}.html doc/bogofilter-tuning.HOWTO.html
	fi
}

pkg_postinst() {
	einfo "Contributed tools and documentation is in ${ROOT}usr/share/${PN}/contrib"
	einfo "beside documentation in ${ROOT}usr/share/doc/${PF}."
}
