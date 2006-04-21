# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.10.ebuild,v 1.9 2006/04/21 17:00:40 vanquirius Exp $

inherit nsplugins eutils

MY_P=linux-5010
DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/${MY_P}.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="cjk noplugin"
RESTRICT="nostrip"

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2-r1 )"
PDEPEND="cjk? ( =media-fonts/acroread-asianfonts-5* )"

INSTALLDIR=/opt/Acrobat5

S="${WORKDIR}/installers"

pkg_setup() {
	# x86 binary package, ABI=x86
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/25
	has_multilib_profile && ABI="x86"
}

pkg_setup() {
	if ! use noplugin ; then
		einfo
		einfo "gtk2 USE flag can cause a slowdown in Mozilla's performance"
		einfo "especially when using the acroread plugin to view a PDF file."
		einfo
	fi
}

src_compile() {
	tar -xvf LINUXRDR.TAR --no-same-owner
	tar -xvf COMMON.TAR --no-same-owner

	sed -e "s:REPLACE_ME:${INSTALLDIR}/Reader:" \
		bin/acroread.sh > acroread

	#epatch ${FILESDIR}/acroread-utf8-gentoo.diff

	# Workaround till lib symlinks change from lib64 to lib32
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	if use amd64 ; then
		sed -i \
			-e "s:^install_dir:export XLOCALEDIR=/usr/X11R6/lib32/X11/locale/\n&:1" acroread \
			|| die "sed failed"
	fi
}

src_install() {
	local i

	dodir ${INSTALLDIR}
	DIRS="Reader Resource"
	use !noplugin && DIRS="${DIRS} Browsers"
	for i in ${DIRS}
	do
		if [ -d ${i} ] ; then
			chown -R --dereference root:root ${i}
			cp -Rd ${i} ${D}${INSTALLDIR}
		fi
	done

	sed -i \
		-e "s:\$PROG =.*:\$PROG = '${INSTALLDIR}/acroread.real':" \
		acroread || die "sed acroread failed"

	exeinto ${INSTALLDIR}
	doexe acroread || die "doexe failed"
	dodoc README LICREAD.TXT

	if ! use noplugin ; then
		dodir /opt/netscape/plugins
		dosym ${INSTALLDIR}/Browsers/intellinux/nppdf.so /opt/netscape/plugins
		inst_plugin ${INSTALLDIR}/Browsers/intellinux/nppdf.so
	fi

	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10acroread5

}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die
}
