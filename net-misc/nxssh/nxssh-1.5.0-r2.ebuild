# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxssh/nxssh-1.5.0-r2.ebuild,v 1.1 2006/04/30 18:33:28 stuart Exp $

inherit multilib flag-o-matic

DESCRIPTION="Modified openssh client, used by nxclient"
HOMEPAGE="http://www.nomachine.com/"

IUSE="ipv6 pam tcpd"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/nxssh-$PV-23.tar.gz"

DEPEND="~net-misc/nxcomp-1.5.0
	>=dev-libs/openssl-0.9.7
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	pam? ( >=sys-libs/pam-0.77 )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# unfortunately this package doesn't honor environment variables correctly
	# in configure, so append-flags doesn't work.
	sed -i 's/-I *..\/nxcomp/-I\/usr\/NX\/include/' configure
}

src_compile() {
	append-flags -I/usr/NX/include
	append-ldflags -L/usr/NX/$(get_libdir)
	./configure \
	    --prefix=/usr \
		--sysconfdir=/etc/ssh \
		--mandir=/usr/share/man \
		--libexecdir=/usr/lib/misc \
		--datadir=/usr/share/openssh \
		--disable-suid-ssh \
		--with-privsep-path=/var/empty \
		--with-privsep-user=sshd \
		--with-md5-passwords \
		$(use_with tcpd tcp-wrappers) \
		$(use_with pam) \
		$(use_with !ipv6 ipv4-default) \
		|| die "configure nxssh failed"
	emake || die "emake nxssh failed"
}

src_install() {
	into /usr/NX
	dobin nxssh
}
