# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.10.2.ebuild,v 1.3 2003/11/17 22:10:37 dholm Exp $

inherit kde
need-kde 3.1

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://k3b.sourceforge.net/"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="debug dvd oggvorbis mad dvdr"

newdepend ">=sys-apps/portage-2.0.49-r8
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/id3lib-3.8.0_pre2
	mad? ( >=media-sound/mad-0.14.2b )
	oggvorbis? ( media-libs/libvorbis )"

RDEPEND="$RDEPEND sys-apps/eject
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	media-sound/normalize
	dvdr? ( app-cdr/dvd+rw-tools )
	dvd? ( media-video/transcode media-libs/xvid )"

LANGS="af bg ca cs cy da de el en_GB eo es et fa fr he hu it
ja nb nl nn pl pt pt_BR ru se sk sl sr sv tr ven xh zh_CN zh_TW"

I18N=${PN}-i18n-${PV/10.2/10}

for pkg in $LANGS
do
	SRC_URI="$SRC_URI linguas_${pkg}? (mirror://sourceforge/k3b/${I18N}.tar.gz)"
done

myconf="$myconf --enable-sso"
[ `use debug` ] \
	&& myconf="$myconf --enable-debugging --enable-profiling" \
	|| myconf="$myconf --disable-debugging --disable-profiling"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	base_src_unpack unpack
}

src_compile() {
	local _S=${S}
	if ! [ -z $LINGUAS ]; then
		echo "SUBDIRS = "${LINGUAS} > ${WORKDIR}/${I18N}/po/Makefile.am
	fi

	# Build process of K3B
	S=${WORKDIR}/k3b-${PV}
	cd ${S} && aclocal
	kde_src_compile myconf
	myconf="$myconf --prefix=$KDEDIR -C"
	kde_src_compile configure
	kde_src_compile make

	# Build process for K3B-i18n
	# I think running this in a for-loop is not necessary, 
	# because there should be only those two directories. 
	# If you find a better way for running aclocal and automake, do so... :)
	S=${WORKDIR}/${I18N}
	ebegin "Running aclocal and automake, fixes bug #32564..."
	kde_src_compile myconf
	aclocal
	if [ "$?" == "0" ];
		then WANT_AUTOMAKE=1.7 automake;
	fi;
	eend $?
	myconf="$myconf --prefix=$KDEDIR -C"
	kde_src_compile configure
	kde_src_compile make

	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/$dir
		make install DESTDIR=${D} destdir=${D}
	done
	S=${_S}
}

pkg_postinst()
{
	einfo "The k3b setup program will offer to change some permissions and"
	einfo "create a user group.  These changes are not necessary.  We recommend"
	einfo "that you clear the two check boxes that let k3b make changes for"
	einfo "cdrecord and cdrdao and let k3b make changes for the devices when"
	einfo "running k3b setup."
}
