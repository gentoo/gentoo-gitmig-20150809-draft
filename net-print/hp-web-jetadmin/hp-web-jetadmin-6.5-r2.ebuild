# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/hp-web-jetadmin/hp-web-jetadmin-6.5-r2.ebuild,v 1.3 2002/08/17 23:09:56 aliz Exp $

# This package, in its most basic form (no optional components) will install
# some 4300 files, totalling some 45MB. According to HP the minimum system
# requirements are a 400MHz CPU with 128MB RAM.

DESCRIPTION="Remotely install, monitor, and troubleshoot network-connected printers"
HOMEPAGE="http://www.hp.com/go/webjetadmin/"
KEYWORDS="x86"

# Optional files, just over 8MB. Havent worked them in yet.
# o wjarda_linux_bundle.fpb: HP Remote Discovery Agent Component
# o wjapps_linux_bundle.fpb: HP Web Print Server Manager Bundle
SRC_URI="http://ftp.hp.com/pub/networking/software/hpwebjet_linux.selfx
         http://www.hp.com/cposupport/manual_set/bpj06492.pdf"
#        http://www.hp.com/pond/wja/live/manual/bundles/wjarda_linux_bundle.fpb
#        http://www.hp.com/pond/wja/live/manual/bundles/wjapps_linux_bundle.fpb"
DEPEND="virtual/glibc"
LICENSE="HP"
SLOT="0"
SANDBOX_DISABLED="1"

src_unpack() { :; } ; src_compile() { :; }

src_install() {
	# masquerade as redhat; neccesary
	install -m 644 ${FILESDIR}/etc.redhat-release /etc/redhat-release

	this-ll_take_a_bit
	chmod 755 ${DISTDIR}/hpwebjet_linux.selfx
	${DISTDIR}/hpwebjet_linux.selfx -s -d ${D}/opt/jetadmin
	assert "Probably missing a DEPEND. Hmm what could it be!"
	dodoc ${DISTDIR}/bpj06492.pdf

	# convenient LDPATH entry
	insinto /etc/env.d ; doins ${FILESDIR}/20jetadmin

	rm -f /etc/init.d/hpwebjetd # this is a little icky
	exeinto /etc/init.d ; newexe ${FILESDIR}/jetadmin.rc6 jetadmin

	# costume
	rm -f /etc/redhat-release # so is this
	# residue
	rm -f /var/lib/fpm/hp* # and this too
}

this-ll_take_a_bit() {
	einfo "+ ------------------------------------------------- +"
	einfo "+   This will take some time to completely merge!   +"
	einfo "+ ------------------------------------------------- +"
	einfo "+  Dont go hitting cntrl-c thinking that its stuck  +"
	einfo "+                 because its not!                  +"
	einfo "+ ------------------------------------------------- +"
}
