# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/luatex/luatex-0.65.0.ebuild,v 1.5 2011/06/13 22:39:44 mattst88 Exp $

EAPI="2"

inherit libtool eutils

DESCRIPTION="An extended version of pdfTeX using Lua as an embedded scripting language."
HOMEPAGE="http://www.luatex.org/"
SRC_URI="http://foundry.supelec.fr/gf/download/frsrelease/386/1704/${PN}-beta-${PV}-source.tar.bz2
	http://foundry.supelec.fr/gf/download/frsrelease/386/1705/${PN}-beta-${PV}-doc.tar.bz2
	mirror://gentoo/${P}-libpng15.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND="dev-libs/zziplib
	>=media-libs/libpng-1.4
	>=app-text/poppler-0.12.3-r3[xpdf-headers]
	sys-libs/zlib
	dev-libs/kpathsea"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-beta-${PV}/source"
PRELIBS="libs/obsdcompat"
#texk/kpathsea"
#kpathsea_extraconf="--disable-shared --disable-largefile"

src_prepare() {
	epatch "${WORKDIR}/${P}-libpng15.patch"
	elibtoolize
}

src_configure() {
	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #244619
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	local myconf
	myconf=""
	#has_version '>=app-text/texlive-core-2009' && myconf="--with-system-kpathsea"

	cd "${S}/texk/web2c"
	econf \
		--disable-cxx-runtime-hack \
		--disable-all-pkgs	\
		--disable-mp		\
		--disable-ptex		\
	    --disable-largefile \
		--disable-ipc		\
		--disable-shared	\
		--enable-luatex		\
		--enable-dump-share	\
		--without-mf-x-toolkit \
		--without-x			\
	    --with-system-kpathsea	\
	    --with-system-gd	\
	    --with-system-libpng	\
	    --with-system-teckit \
	    --with-system-zlib \
	    --with-system-t1lib \
		--with-system-xpdf \
		--with-system-poppler \
		--with-system-zziplib \
	    --disable-multiplatform \

	for i in ${PRELIBS} ; do
		einfo "Configuring $i"
		local j=$(basename $i)_extraconf
		local myconf
		eval myconf=\${$j}
		cd "${S}/${i}"
		econf ${myconf}
	done
}

src_compile() {
	for i in ${PRELIBS} ; do
		cd "${S}/${i}"
		emake || die "failed to build ${i}"
	done
	cd "${WORKDIR}/${PN}-beta-${PV}/source/texk/web2c"
	emake luatex || die "failed to build luatex"
}

src_install() {
	cd "${WORKDIR}/${PN}-beta-${PV}/source/texk/web2c"
	emake DESTDIR="${D}" bin_PROGRAMS="luatex" SUBDIRS="" nodist_man_MANS="" \
		install-exec-am || die

	dodoc "${WORKDIR}/${PN}-beta-${PV}/README" || die
	newman "${WORKDIR}/${PN}-beta-${PV}/manual/${PN}.man" "${PN}.1" || die
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins "${WORKDIR}/${PN}-beta-${PV}/manual/"*.pdf || die
	fi
}

pkg_postinst() {
	if ! has_version '>=dev-texlive/texlive-basic-2008' ; then
		elog "Please note that this package does not install much files, mainly the"
		elog "${PN} executable that will need other files in order to be useful.."
		elog "Please consider installing a recent TeX distribution"
		elog "like TeX Live 2008 to get the full power of ${PN}"
	fi
	if [ "$ROOT" = "/" ] && [ -x /usr/bin/fmtutil-sys ] ; then
		einfo "Rebuilding formats"
		/usr/bin/fmtutil-sys --all &> /dev/null
	else
		ewarn "Cannot run fmtutil-sys for some reason."
		ewarn "Your formats might be inconsistent with your installed ${PN} version"
		ewarn "Please try to figure what has happened"
	fi
}
