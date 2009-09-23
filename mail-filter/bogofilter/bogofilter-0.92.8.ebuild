# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.92.8.ebuild,v 1.16 2009/09/23 17:51:56 patrick Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips"
IUSE="doc"

RDEPEND=">=sys-libs/db-3.2"
DEPEND="${DEPEND}
	doc? ( app-text/xmlto )"

src_compile() {
	econf --with-included-gsl || die "configure failed"
	emake || die "make failed"
}

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
