# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/modelsim/modelsim-5.7d.ebuild,v 1.2 2003/09/08 07:26:32 msterret Exp $

DESCRIPTION="VHDL and mixed-VHDL/Verilog simulator"
HOMEPAGE="http://www.model.com/"
SRC_URI="modeltech-base.tar.gz
	modeltech-linux.exe.gz
	doc? ( modeltech-docs.tar.gz )"

LICENSE="modelsim"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="nostrip fetch"

DEPEND=""

pkg_nofetch() {
	einfo "You must download the files yourself and put them in ${DISTDIR}"
	einfo "Goto http://www.model.com/products/release.asp"
}

src_unpack() {
	unpack modeltech-base.tar.gz
	use doc && unpack modeltech-docs.tar.gz
	gzip -c -d ${DISTDIR}/modeltech-linux.exe.gz > modeltech-linux.exe || die "gzip -c -d"
	chmod +x modeltech-linux.exe
	echo -n -e "D\nAgree\n"|./modeltech-linux.exe > /dev/null
}

src_install() {
	dodir /opt
	cp -r ${WORKDIR}/modeltech ${D}/opt/
	insinto /etc/env.d
	echo "PATH=/opt/modeltech/bin" > 90modelsimSE
	doins 90modelsimSE
}

pkg_postinst() {
	einfo "Read the installation manual for details of configuring a"
	einfo "standalone license server, or set LM_LICENSE_FILE=xxxx@host"
	einfo "if you already have a running license server"
}
