# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/glade/glade-2006.0.ebuild,v 1.1 2007/02/05 10:35:15 george Exp $

inherit gnat

IUSE=""

DESCRIPTION="An implementation of the Distributed Systems Annex for the GNAT compiler"
HOMEPAGE="http://libre2.adacore.com/"
SRC_URI="http://dev.gentoo.org/~george/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/gnat"

# temporary install pool
DN="${WORKDIR}/LocalD"

src_unpack() {
	gnat_src_unpack

	cd ${S}
	# configure performs some stupid check and in a wrong way, we will surely
	# have a modern enough gnat
	sed -i -e "s:-le \"\$am_gnatls_date\":-le \"20040909\":" configure
}

lib_compile()
{
	econf --with-optimization="${CFLAGS}" || die "econf failed"
	emake || die "make failed"
	einfo "lib_compile completed"
}

# NOTE: we are using $1 - the passed gnat profile name
lib_install()
{
	# ATTN!
	# get_gnat_value relies on having a value specific for gnat in the first
	# position of a requested env var. Above works for PATH because gnat.eclass
	# prepends values from the freshly activated gnat profile!
	#
	# Also, we install directly to ${D} here, as this is really a part of gnat
	make prefix=${DN} \
		bindir=${DN}/$(get_gnat_value PATH) \
		install || die "make install failed"
	#
	# Makefile does not seem to accept much more than bindir, so the rest we
	# will move manually
	local Gnat_Libdir=$(get_gnat_value ADA_OBJECTS_PATH)
	local Gnat_Incdir=$(get_gnat_value ADA_INCLUDE_PATH)
	mkdir -p "${DN}/${Gnat_Libdir}"
	mv "${DN}/lib/garlic"/*.ali "${DN}/lib/garlic"/libgarlic.a "${DN}/${Gnat_Libdir}"

	mkdir -p "${DN}/${Gnat_Incdir}"
	mv "${DN}/lib/garlic"/*.ad? "${DN}/${Gnat_Incdir}"
	rm -rf "${DN}/lib"
}

src_install ()
{
	# library is installed into the corresponding gnat, no extra env setting
	# necessary
	echo "" > ${LibEnv}

	gnat_src_install

	# clean empty dirs
	rm -rf ${D}/usr/share/gnat/ ${D}/usr/lib/ada/

	# move prepared stuff over
	cp -rp "${DN}"/* ${D}
	dodoc COPYING README NEWS
	insinto /usr/share/doc/${PF}
	doins -r  Examples/
}

pkg_postinst() {
	echo
	elog "GLADE has been installed at the gnat compiler location, expanding	System Library."
	elog "No further configuration is necessary. Enjoy."
	echo
}
