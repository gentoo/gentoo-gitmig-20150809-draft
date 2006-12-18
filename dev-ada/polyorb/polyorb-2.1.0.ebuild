# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/polyorb/polyorb-2.1.0.ebuild,v 1.1 2006/12/18 14:06:08 george Exp $

inherit gnat

IUSE="doc ssl"

DESCRIPTION="A CORBA implementation for Ada"
HOMEPAGE="http://libre2.adacore.com/polyorb/"
SRC_URI="http://dev.gentoo.org/~george/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/gnat"


#lib_compile()
lib_compile()
{
	econf --libdir=/usr/lib \
		$(use_with ssl openssl) || die "econf failed"
		#--enable-shared \
		# NOTE: --libdir is passed here to simplify logic - all the proper files
		# are anyway moved to the final destination by the eclass
	emake || die "make failed"
}

# NOTE: we are using $1 - the passed gnat profile name
#lib_install() {
lib_install()
{
	make DESTDIR=${DL} install || die "install failed"

	# move installed files to appropriate locations
	mv ${DL}/usr/* ${DL}
	find ${DL} -name "*.ali" -exec mv {} ${DL}/lib \;
	chmod 0444 ${DL}/lib/*.ali

	# remove sources and other common stuff
	rm -rf "${DL}"/{include,usr}
	# fix paths in polyorb-config
	sed -i -e "s:includedir=\"\${prefix}/include\":includedir=/usr/include/ada:" \
		-e "s:libdir=\"/usr/lib\":libdir=${AdalibLibTop}/$1/${PN}/lib:" \
		${DL}/bin/${PN}-config
}

src_install ()
{
	cd ${S}
	# install sources
	dodir ${AdalibSpecsDir}/${PN}
	insinto ${AdalibSpecsDir}/${PN}
	doins -r src/*

	#set up environment
	echo "PATH=%DL%/bin" > ${LibEnv}
	echo "LDPATH=%DL%/lib" >> ${LibEnv}
	echo "ADA_OBJECTS_PATH=%DL%/lib" >> ${LibEnv}
	echo "ADA_INCLUDE_PATH=/usr/include/ada/${PN}" >> ${LibEnv}

	gnat_src_install

	dodoc CHANGE_10049 COPYING FEATURES MANIFEST NEWS README
	doinfo docs/*.info
	if use doc; then
		dohtml docs/polyorb_ug.html/*.html
		insinto /usr/share/doc/${PF}
		doins docs/*.pdf

		dodir /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
