# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-9999.ebuild,v 1.1 2007/12/31 20:37:57 vapier Exp $

ECVS_SERVER="cvs.sv.gnu.org:/sources/libtool"
ECVS_MODULE="libtool"
inherit cvs

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"

LICENSE="GPL-2"
SLOT="1.5"
KEYWORDS=""
IUSE=""

RDEPEND="sys-devel/gnuconfig
	>=sys-devel/autoconf-2.60
	>=sys-devel/automake-1.10"
DEPEND="${RDEPEND}
	sys-apps/help2man"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	./bootstrap || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	local x
	for x in libtool libtoolize ; do
		help2man ${x} > ${x}.1
		doman ${x}.1 || die
	done

	for x in $(find "${D}" -name config.guess -o -name config.sub) ; do
		rm -f "${x}" ; ln -sf ../gnuconfig/$(basename "${x}") "${x}"
	done
	cd "${D}"/usr/share/libtool/libltdl
	for x in config.guess config.sub ; do
		rm -f ${x} ; ln -sfn ../${x} ${x}
	done
}
