# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fmod/fmod-4.21.06.ebuild,v 1.2 2009/05/12 22:15:08 ssuominen Exp $

inherit multilib versionator

MY_P=fmodapi$(delete_all_version_separators)linux

DESCRIPTION="music and sound effects library, and a sound processing system"
HOMEPAGE="http://www.fmod.org"
SRC_URI="x86? ( http://www.fmod.org/index.php/release/version/${MY_P}.tar.gz )
	amd64? ( http://www.fmod.org/index.php/release/version/${MY_P}64.tar.gz )"

LICENSE="fmod"
SLOT="1"
KEYWORDS="-* ~amd64 ~x86"
IUSE="doc examples"

RDEPEND=""
DEPEND=""

RESTRICT="strip test"

QA_TEXTRELS="usr/lib*/libfmod*.so*
	usr/lib*/fmodex/plugins/*.so*"
QA_EXECSTACK="usr/lib*/libfmod*.so*
	usr/lib*/fmodex/plugins/*.so*"

if use amd64; then
	S=${WORKDIR}/${MY_P}64
else
	S=${WORKDIR}/${MY_P}
fi

src_compile() { :; }

src_install() {
	dolib {.,fmoddesignerapi}/api/lib/*

	# Bug 257419 for now, but next ebuild needs to be sorted out
	rm -f "${D}"/usr/$(get_libdir)/*.0[2-5].so

	insinto /usr/$(get_libdir)/fmodex/plugins
	doins api/plugins/*.so

	# Loop it with some temp. variable? Fugly but working.
	if use amd64; then
		dosym libfmodevent64.so /usr/$(get_libdir)/libfmodevent64.so.${PV}
		dosym libfmodevent64.so /usr/$(get_libdir)/libfmodevent.so
		dosym libfmodevent64.so /usr/$(get_libdir)/libfmodevent64.so.${PV}
		dosym libfmodex64.so.${PV} /usr/$(get_libdir)/libfmodex.so
		dosym libfmodex64.so.${PV} /usr/$(get_libdir)/libfmodex.so.${PV}
		dosym libfmodexp64.so.${PV} /usr/$(get_libdir)/libfmodexp.so
		dosym libfmodexp64.so.${PV} /usr/$(get_libdir)/libfmodexp.so.${PV}
	else
		dosym libfmodevent.so /usr/$(get_libdir)/libfmodevent.so.${PV}
	fi

	insinto /usr/include/fmodex
	doins {.,fmoddesignerapi}/api/inc/*

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins -r {.,fmoddesignerapi}/examples/* tools/* || die "doins failed."
	fi

	dodoc documentation/*.txt

	use doc && dodoc documentation/*.pdf
}
