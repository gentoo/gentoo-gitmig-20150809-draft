# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.93.2.ebuild,v 1.1 2004/12/14 00:26:15 tove Exp $

inherit eutils

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gsl notransactions"

RDEPEND="virtual/libc
	>=sys-libs/db-3.2
	gsl? ( dev-libs/gsl )"
#	app-arch/pax" # only needed for bf_tar

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	DB_SLOT="$(best_version sys-libs/db | sed -e 's/sys-libs\/db-\(3\|4\.[123]\|4\).*/\1/')"
	sed -e "s/db_\(copy\|compact\)/bf_\1/g" \
		-e "s/db_\(checkpoint\|archive\|stat\|recover\)/db${DB_SLOT}_\1/g" \
		-i src/bf_compact -i src/bf_copy -i src/bf_tar -i src/bf_resize \
		|| die "sed failed"
}

src_compile() {
	local myconf
	myconf="$(use_with !gsl included-gsl)
		$(use_enable !notransactions transactions)"
	econf ${myconf} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/share/${PN}/contrib
	doexe contrib/{bogofilter-qfe,bogogrep,mime.get.rfc822,parmtest.sh}
	doexe contrib/{randomtrain,scramble,*.pl}

	insinto /usr/share/${PN}/contrib
	doins contrib/{README.*,bogo.R,bogogrep.c,dot-qmail-bogofilter-default}
	doins contrib/{trainbogo.sh,*.example}

	dodoc AUTHORS COPYING INSTALL NEWS README #CHANGES*
	dodoc RELEASE.NOTES* TODO doc/integrating-with-*
	dodoc GETTING.STARTED doc/README.db

	dodir /usr/share/doc/${PF}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	if useq doc; then
		dohtml doc/*.html
	else
		dohtml doc/bogofilter-faq{,-fr}.html doc/bogofilter-tuning.HOWTO.html
	fi
}

pkg_postinst() {
	ewarn "Incompatible changes in bogofilter-0.93:"
	ewarn "Please read the documentation (RELEASE.NOTES, README.db)!"
	einfo "If you need /use/bin/bf_tar please install app-arch/pax."
	ebeep
	einfo "Contributed tools and documentation is in ${ROOT}usr/share/${PN}/contrib"
	einfo "beside documentation in ${ROOT}usr/share/doc/${PF}."
}
