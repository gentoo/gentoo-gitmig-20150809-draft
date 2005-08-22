# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rsh/netkit-rsh-0.17-r6.ebuild,v 1.10 2005/08/22 22:15:34 vapier Exp $

inherit eutils pam

DESCRIPTION="Netkit's Remote Shell Suite: rexec{,d} rlogin{,d} rsh{,d}"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz
	mirror://gentoo/rexec-1.5.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="pam"

DEPEND=">=sys-libs/ncurses-5.2
	pam? ( >=sys-libs/pam-0.72 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	unpack rexec-1.5.tar.gz
	for p in $(grep -v '^#' "${FILESDIR}"/redhat.spec) ; do
		EPATCH_SINGLE_MSG="Applying Redhat's ${p} ..." \
		epatch "${FILESDIR}"/${p}
	done
	sed -i \
		-e '/LDFLAGS/s:$: -Wl,-z,now:' \
		r{cp,login,sh}/Makefile
}

src_compile() {
	local myconf
	use pam || myconf="--without-pam"
	./configure ${myconf} || die

	sed -i \
		-e "s:-pipe -O2:${CFLAGS}:" \
		-e "s:-Wpointer-arith::" \
		MCONFIG
	make || die
}

src_install() {
	local b exe
	insinto /etc/xinetd.d
	for b in rcp rexec{,d} rlogin{,d} rsh{,d} ; do
		if [[ ${b:0-1} == "d" ]] ; then
			dosbin ${b}/${b} || die "dosbin ${b} failed"
			dosym ${b} /usr/sbin/in.${b}
			doman ${b}/${b}.8
		else
			dobin ${b}/${b} || die "dobin ${b} failed"
			doman ${b}/${b}.1
			[[ ${b} != "rexec" ]] \
				&& fperms 4711 /usr/bin/${b}
			[[ ${b} != "rcp" ]] \
				&& newins "${FILESDIR}"/${b}.xinetd ${b} \
				&& newpamd "${FILESDIR}"/${b}.pamd ${b}
		fi
	done
	dodoc  README ChangeLog BUGS
	newdoc rexec/README README.rexec
}
