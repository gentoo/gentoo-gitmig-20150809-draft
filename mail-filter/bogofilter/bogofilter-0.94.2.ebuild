# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.94.2.ebuild,v 1.1 2005/03/25 02:35:58 tove Exp $

inherit eutils

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~arm ~ppc64" # missing, see bug #74046
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gsl"

RDEPEND="virtual/libc
	>=sys-libs/db-3.2
	gsl? ( sci-libs/gsl )"
#	app-arch/pax" # only needed for bf_tar

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	DB_SLOT="$(best_version sys-libs/db | sed -e 's/sys-libs\/db-\(3\|4\.[123]\|4\).*/\1/' )"
	sed -e "s/db_\(checkpoint\|archive\|stat\|recover\)/db${DB_SLOT}_\1/g" \
		-i src/bf_compact src/bf_copy src/bf_tar src/bf_resize \
		|| die "sed failed - echo ${DB_SLOT}"
}

src_compile() {
	local myconf=""
	use !gsl && myconf="--with-included-gsl" # 'without-' doesn't work

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

	dodoc AUTHORS COPYING INSTALL NEWS README
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
	ewarn "Incompatible changes in bogofilter-0.93 and -0.94:"
	ewarn "Please read the documentation (RELEASE.NOTES, README.db)!"
	einfo "If you need ${ROOT}use/bin/bf_tar please install app-arch/pax."
	ebeep
	einfo "Contributed tools and documentation is in ${ROOT}usr/share/${PN}/contrib"
	einfo "beside documentation in ${ROOT}usr/share/doc/${PF}."
}
