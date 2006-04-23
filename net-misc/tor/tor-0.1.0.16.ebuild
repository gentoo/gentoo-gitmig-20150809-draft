# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.1.0.16.ebuild,v 1.3 2006/04/23 15:31:36 exg Exp $

inherit eutils flag-o-matic

DESCRIPTION="The Onion Router - Anonymizing overlay network for TCP"
HOMEPAGE="http://tor.eff.org/"
SRC_URI="http://tor.eff.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
## Arch temas please please dont mark this stable untill you really test the
## chroot stuff
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

DEPEND=">=dev-libs/openssl-0.9.6
		dev-libs/libevent"
RDEPEND="!static? (
			net-proxy/tsocks
			>=dev-libs/openssl-0.9.6
			dev-libs/libevent
		)"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/torrc.sample-0.1.0.16.patch
}

src_compile() {
	use static && append-ldflags -static
	use static && append-flags -static
	econf || die
	emake || die
}

src_install() {
	exeinto /etc/init.d ; newexe ${FILESDIR}/tor.initd-r1 tor
	insinto /etc/conf.d ; newins ${FILESDIR}/tor.confd tor
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS INSTALL \
		doc/{CLIENTS,FAQ,HACKING,TODO} \
		doc/{control-spec.txt,rend-spec.txt,tor-doc.css,tor-doc.html,tor-spec.txt}

	dodir /var/lib/tor
	dodir /var/log/tor
	fperms 750 /var/lib/tor /var/log/tor
	fowners tor:tor /var/lib/tor /var/log/tor
}

pkg_postinst() {
	einfo "You must create /etc/tor/torrc, you can use the sample that is in that directory"
	einfo "To have privoxy and tor working together you must add:"
	einfo "forward-socks4a / localhost:9050 ."
	einfo "to /etc/privoxy/config"
	einfo
	einfo "The Tor ebuild now includes chroot support."
	einfo "If you like to run tor in chroot AND this is a new install OR"
	einfo "your tor doesn't already run in chroot, simply run:"
	einfo "\`ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\`"
	einfo "Before running the above command you might want to change the chroot"
	einfo "dir in /etc/conf.d/tor. Otherwise /chroot/tor will be used."
}

pkg_config() {
	CHROOT=`sed -n 's/^[[:blank:]]\?CHROOT="\([^"]\+\)"/\1/p' /etc/conf.d/tor 2>/dev/null`
	EXISTS="no"

	if [ -z "${CHROOT}" -a ! -d "/chroot/tor" ]; then
		CHROOT="/chroot/tor"
	elif [ -d ${CHROOT} ]; then
		eerror; eerror "${CHROOT:-/chroot/tor} already exists. Quitting."; eerror; EXISTS="yes"
	fi

	if [ ! "$EXISTS" = yes ]; then
		USERNAME="tor"
		BINARY="/usr/bin/tor"

		einfo
		einfo "Setting up the chroot directory..."
		mkdir -m 700 -p ${CHROOT}
		mkdir -p ${CHROOT}/etc/tor \
			${CHROOT}/dev ${CHROOT}/var/log/tor ${CHROOT}/var/lib/tor \
			${CHROOT}/usr/bin ${CHROOT}/var/run ${CHROOT}/lib \
			${CHROOT}/usr/lib

		einfo "Creating devices..."
		mknod -m 0444 ${CHROOT}/dev/random c 1 8
		mknod -m 0444 ${CHROOT}/dev/urandom c 1 9
		mknod -m 0666 ${CHROOT}/dev/null c 1 3

		einfo "Adding ${USERNAME} to ${CHROOT}/etc/passwd and group..."
		grep ^${USERNAME}: /etc/passwd > ${CHROOT}/etc/passwd
		grep ^${USERNAME}: /etc/group > ${CHROOT}/etc/group

		einfo "Copying system files..."
		cp -p /etc/{nsswitch.conf,host.conf,resolv.conf,hosts,localtime} ${CHROOT}/etc
		cp -p /lib/{libc.*,libnsl.*,libnss_*.*,libresolv.*,libgcc_*.*,ld-linux.*} ${CHROOT}/lib

		# Static version has no dynamic dependencies
		if useq !static ; then
			einfo "Copying dependencies..."
			for DEP in $(ldd $BINARY | awk '{print $3}'); do
				test -f ${DEP} && cp ${DEP} ${CHROOT}${DEP}
			done
		fi

		einfo "Copying binaries and config files..."
		for i in ${BINARY}; do
			cp ${i} ${CHROOT}${i}
		done

		cp -R /etc/tor ${CHROOT}/etc/
		cp -Rp /var/lib/tor ${CHROOT}/var/lib/

		einfo "Setting permissions..."
		chown ${USERNAME}:${USERNAME} ${CHROOT} ${CHROOT}/var/lib/tor \
			${CHROOT}/var/log/tor ${CHROOT}/var/run
		chmod 0700 ${CHROOT}/var/lib/tor ${CHROOT}/var/run ${CHROOT}/var/log/tor
		chmod 0444 ${CHROOT}/etc/{group,host.conf,hosts,localtime,nsswitch.conf}
		chmod 0444 ${CHROOT}/etc/{passwd,resolv.conf}
		chmod 0644 ${CHROOT}/etc/tor/*

		einfo "Done."
	fi
}
