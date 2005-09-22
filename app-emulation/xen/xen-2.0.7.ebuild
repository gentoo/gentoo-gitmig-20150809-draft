# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/xen-2.0.7.ebuild,v 1.3 2005/09/22 22:18:34 chrb Exp $

inherit mount-boot

DESCRIPTION="The Xen virtual machine monitor and Xend daemon"
HOMEPAGE="http://xen.sourceforge.net"
SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug"

DEPEND="sys-apps/iproute2
	net-misc/bridge-utils
	dev-lang/python
	=dev-python/twisted-1.3.0
	net-misc/curl
	sys-libs/zlib
	doc? (
		dev-tex/latex2html
		media-gfx/transfig
	)"

S="${WORKDIR}/${PN}-2.0"

src_unpack() {
	unpack ${A}
	# hardened flags
	echo "CFLAGS += -nopie -fno-stack-protector -fno-stack-protector-all" \
	    >> ${S}/xen/arch/x86/Rules.mk
}

src_compile() {
	local myopt
	if use debug; then
		myopt="${myopt} debug=y"
	fi

	unset CFLAGS
	emake ${myopt} -C xen || die "compiling xen failed"
	emake ${myopt} -C tools || die "compiling tools failed"

	if use doc; then
		sh ./docs/check_pkgs || die "package check failed"
		emake ${myopt} -C docs || die "compiling docs failed"
	fi

}

src_install() {
	make DESTDIR=${D} -C xen install || die "installing xen failed"

	make DESTDIR=${D} XEN_PYTHON_NATIVE_INSTALL=1 -C tools install \
	    || die "installing tools failed"

	if use doc; then
		make DESTDIR=${D} -C docs install \
			|| die "installing docs failed"
		# Rename doc/xen to the Gentoo-style doc/xen-2.0
		mv ${D}/usr/share/doc/{${PN},${PF}}
	fi

	# bind xend to localhost per default
	sed -i -e "s/\((xend-address  *\)'')/\1\'localhost\')/" \
		${D}/etc/xen/xend-config.sxp

	newinitd ${FILESDIR}/xend-init xend
	newconfd ${FILESDIR}/xend-conf xend
	newconfd ${FILESDIR}/xendomains-conf xendomains
	newinitd ${FILESDIR}/xendomains-init xendomains

	# install kernel specific source patches
	dodir /usr/share/xen/patches
	rm patches/linux-2.6.11/linux-2.6.11.12.patch
	cd patches
	for x in *; do tar -jcvf ${D}/usr/share/xen/patches/${x}.tar.bz2 ${x}/; done
	cd ..

	# we need to do whatever mkbuildtree would've done for each platform
	# linux-2.6: copy public include files, and xenstored.h
	mkdir linux-2.6.11-xen-sparse/include/asm-xen/xen-public
	# include files for kernel
	rm xen/include/public/COPYING
	cp -dpPR xen/include/public/* linux-2.6.11-xen-sparse/include/asm-xen/xen-public
	# fixme: insert code for other sparse trees here

	# install xen kernel sparse trees
	mv linux-2.6.11-xen-sparse linux-2.6-xen-sparse
	mv linux-2.4.30-xen-sparse linux-2.4-xen-sparse
	for x in *-xen-sparse; do
	    if [ -e ${x}/mkbuildtree ]; then rm ${x}/mkbuildtree; fi
	    tar -jcvf ${D}/usr/share/xen/${x}.tar.bz2 -C ${x} .
	done

}

pkg_postinst() {
	einfo "Please visit the Xen and Gentoo wiki:"
	einfo "http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"
}
