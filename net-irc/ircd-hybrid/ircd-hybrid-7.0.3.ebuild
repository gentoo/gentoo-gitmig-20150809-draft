# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircd-hybrid/ircd-hybrid-7.0.3.ebuild,v 1.6 2005/12/31 13:57:49 flameeyes Exp $

inherit eutils fixheadtails

MAX_NICK_LENGTH=30
MAX_CLIENTS=500
MAX_TOPIC_LENGTH=512
LARGE_NETWORK=
DISABLE_LARGE_NETWORK=1
SMALL_NETWORK=1
DISABLE_SMALL_NETWORK=
ENABLE_POLL=1
DISABLE_POLL=
ENABLE_SELECT=
DISABLE_SELECT=1
ENABLE_EFNET=
ENABLE_RTSIGIO=
DISABLE_RTSIGIO=
ENABLE_SHARED=1
DISABLE_SHARED=
ENABLE_DEVPOLL=
DISABLE_DEVPOLL=1
ENABLE_KQUEUE=
DISABLE_KQUEUE=

IUSE="debug ipv6 ssl static zlib"

DESCRIPTION="IRCD-Hybrid - High Performance Internet Relay Chat"
HOMEPAGE="http://ircd-hybrid.com/"
SRC_URI="mirror://sourceforge/ircd-hybrid/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"

DEPEND="virtual/libc
	zlib? ( >=sys-libs/zlib-1.1.4-r2 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	|| ( >=dev-libs/libelf-0.8.2 >=dev-libs/elfutils-0.94-r1 )
	>=sys-devel/flex-2.5.4a-r5
	>=sys-devel/bison-1.875
	>=sys-devel/gettext-0.12.1
	>=sys-apps/sed-4.0.7"
RDEPEND=""

pkg_setup() {
	enewgroup hybrid
	enewuser hybrid -1 -1 /dev/null hybrid
}

src_unpack() {
	unpack ${A}
	cd ${S}

	ht_fix_file ${S}/configure

	# Patch Makefile.ins:
	# * Add includedir variable where to install headers.
	# * Remove creation of logdirs under prefix. Use /var/log/ircd instead.
	# * Remove symlinking which won't work in sandbox. Done in src_install().
	# Sed hardcoded CFLAGS to those in make.conf.
	epatch ${FILESDIR}/${PF}.diff || die "epatch failed"
	sed -i -e "s:IRC_CFLAGS=\"-O2 -g \":IRC_CFLAGS=\"${CFLAGS}\":" configure

	# Store unmodified source tree for compiling necessary shared libs and
	# binaries with ipv6 support.
	if use ipv6
	then
		mkdir ${T}/ipv6
		cp -r ${S} ${T}/ipv6
	fi
}

src_compile() {
	local myconf=""

	ewarn "Server administrators are encouraged to customize some variables in"
	ewarn "the ebuild if actually deploying hybrid in an IRC network."
	ewarn "The values below reflect a usable configuration but may not be"
	ewarn "for large networks in production environments"
	ewarn "Portage overlay would be benificial for such a senario"
	ewarn
	ewarn "If you require more than 1024 clients per ircd enable poll() support"
	ewarn "or hybrid will not compile due to hard max file descriptor limits"
	ewarn "To change the default settings below you must edit the ebuild"
	ewarn
	ewarn "Maximum nick length       = ${MAX_NICK_LENGTH}"
	ewarn "        topic length      = ${MAX_TOPIC_LENGTH}"
	ewarn "        number of clients = ${MAX_CLIENTS}"
	ewarn

	if [ ${LARGE_NETWORK} ]
	then
		ewarn "Configuring for large networks."
		myconf="${myconf} --enable-large-net"
	fi
	if [ ${DISABLE_LARGE_NETWORK} ]
	then
		ewarn "Disabling large networks."
		myconf="${myconf} --disable-large-net"
	fi
	if [ ${SMALL_NETWORK} ]
	then
		ewarn "Configuring for small networks."
		myconf="${myconf} --enable-small-net"
	fi
	if [ ${DISABLE_SMALL_NETWORK} ]
	then
		ewarn "Disabling small networks."
		myconf="${myconf} --disable-small-net"
	fi
	if [ ${ENABLE_POLL} ]
	then
		ewarn "Configuring with poll() enabled"
		myconf="${myconf} --enable-poll"
	fi
	if [ ${DISABLE_POLL} ]
	then
		ewarn "Configuring with poll() disabled"
		myconf="${myconf} --disable-poll"
	fi
	if [ ${ENABLE_SELECT} ]
	then
		ewarn "Configuring with select() enabled."
		myconf="${myconf} --enable-select"
	fi
	if [ ${DISABLE_SELECT} ]
	then
		ewarn "Configuring with select() disabled."
		myconf="${myconf} --disable-select"
	fi
	if [ ${ENABLE_EFNET} ]
	then
		ewarn "Configuring for Efnet."
		myconf="${myconf} --enable-efnet"
	fi
	if [ ${ENABLE_RTSIGIO} ]
	then
		ewarn "Configuring with Superior RTSIGIO."
		myconf="${myconf} --enable-rtsigio"
	fi
	if [ ${DISABLE_RTSIGIO} ]
	then
		ewarn "Disabling Superior RTSIGIO."
		myconf="${myconf} --disable-rtsigio"
	fi
	if [ ${ENABLE_SHARED} ]
	then
		ewarn "Configuring for non-Efnet."
		myconf="${myconf} --enable-shared"
	fi
	if [ ${ENABLE_KQUEUE} ]
	then
		ewarn "Configuring for Kqueue."
		myconf="${myconf} --enable-kqueue"
	fi
	if [ ${DISABLE_KQUEUE} ]
	then
		ewarn "Disabling Kqueue."
		myconf="${myconf} --disable-kqueue"
	fi

	# Wait for admins to see the default variables.
	epause 5

	# Set ipv4 defaults to config.h.
	patch include/config.h ${FILESDIR}/config-ipv4-${PVR}.diff \
		|| die "ipv4 defaults patch failed"

	# Set prefix to /usr/share/ircd-hybrid-7 to save some patching.
	econf \
		--prefix=/usr/share/ircd-hybrid-7 \
		--with-nicklen=${MAX_NICK_LENGTH} \
		--with-topiclen=${MAX_TOPIC_LENGTH} \
		--with-maxclients=${MAX_CLIENTS} \
		$(use_enable zlib) \
		$(use_enable ssl openssl) \
		$(use_enable !static shared-modules) \
		$(use_enable debug assert) \
		${myconf} \
		|| die "ipv4 config failed"
	emake || die "ipv4 make failed"

	# Enable help index.
	cd help
	make index || die "make index failed"
	cd ..

	# Build respond binary for using rsa keys instead of plain text oper 
	# passwords.
	use ssl && gcc ${CFLAGS} -o respond tools/rsa_respond/respond.c -lcrypto

	# Configure and compile with ipv6 support in temp.
	if use ipv6
	then
		einfo "IPv6 support"
		cd ${T}/ipv6/${P}

		# Set ipv6 defaults to config.h.
		patch include/config.h ${FILESDIR}/config-ipv6-${PVR}.diff \
			|| die "ipv6 defaults patch failed"

		econf \
			--prefix=/usr/share/ircd-hybrid-7 \
			--with-nicklen=${MAX_NICK_LENGTH} \
			--with-topiclen=${MAX_TOPIC_LENGTH} \
			--with-maxclients=${MAX_CLIENTS} \
			--enable-ipv6 \
			$(use_enable zlib) \
			$(use_enable ssl openssl) \
			$(use_enable !static shared-modules) \
			$(use_enable debug assert) \
			${myconf} \
			|| die "ipv6 config failed"
		emake || die "ipv6 make failed"
	fi
}

src_install()
{
	# Directories need to exist beforehand or the install will fail.
	dodir \
		/usr/share/man/man8 \
		/usr/lib/ircd-hybrid-7 \
		/usr/include/ircd-hybrid-7 \
		/var/log/ircd \
		/var/run/ircd \
		/etc/init.d \
		/etc/conf.d
	keepdir /var/run/ircd /var/log/ircd

	# Override all install directories according to the patches with sandbox
	# prefix. 
	make \
		prefix=${D}/usr/share/ircd-hybrid-7/ \
		bindir=${D}/usr/sbin/ \
		sysconfdir=${D}/etc/ircd/ \
		moduledir=${D}/usr/lib/ircd-hybrid-7/ipv4 \
		automoduledir=${D}/usr/lib/ircd-hybrid-7/ipv4/autoload/ \
		messagedir=${D}/usr/share/ircd-hybrid-7/messages/ \
		includedir=${D}/usr/include/ircd-hybrid-7 \
		mandir=${D}/usr/share/man/man8/ \
		install || die "ipv4 install failed"
	mv ${D}/usr/sbin/{,ircd-}mkpasswd #6428

	# Rename the binary according to config-ipv4.diff.
	mv ${D}/usr/sbin/ircd ${D}/usr/sbin/ircd-ipv4

	# Install the respond binary.
	use ssl && dosbin ${S}/respond

	# Do the symlinking.
	local link
	local symlinks="topic accept cjoin cmode admin names links away whowas \
		version kick who invite quit join list nick oper part \
		time credits motd userhost users whois ison lusers \
		user help pass error challenge knock ping pong"
	for link in ${symlinks}
	do
		dosym "../opers/${link}" "/usr/share/ircd-hybrid-7/help/users/${link}"
	done

	dosym viconf /usr/sbin/vimotd
	dosym viconf /usr/sbin/viklines

	# Install documentation.
	dodoc BUGS ChangeLog Hybrid-team INSTALL LICENSE README.* RELNOTES TODO
	docinto doc
	dodoc \
		doc/*.txt doc/README.cidr_bans doc/Tao-of-IRC.940110 \
		doc/convertconf-example.conf doc/example.* doc/ircd.motd \
		doc/simple.conf doc/server-version-info
	docinto doc/technical
	dodoc doc/technical/*

	# Fix the config files according to the patches.
	rm ${D}/etc/ircd/.convertconf-example.conf  # No need for 2 copies.
	local conf
	for conf in ${D}/etc/ircd/*.conf; do
		sed -e "s:/usr/local/ircd/modules:/usr/lib/ircd-hybrid-7/ipv4:g" \
			< ${conf} > ${conf/%.conf/-ipv4.conf}
		rm ${conf}
	done
	mv ${D}/etc/ircd/ircd.motd ${D}/etc/ircd/ircd-ipv4.motd

	# Only the shared libraries and the ircd binary differ from the ipv4
	# installation. Thus installing those is sufficient to make ipv6 support
	# work (and different config files, pid files etc. of cource). 
	if use ipv6
	then
		cd ${T}/ipv6/${P}/modules
		make \
			prefix=${D}/usr/share/ircd-hybrid-7/ \
			moduledir=${D}/usr/lib/ircd-hybrid-7/ipv6 \
			automoduledir=${D}/usr/lib/ircd-hybrid-7/ipv6/autoload/ \
			install || die "ipv6 install failed"
		cp ../src/ircd ${D}/usr/sbin/ircd-ipv6

		# Fix the config files according to the patches.
		for conf in ${D}/etc/ircd/*.conf; do
			sed -e "s:ircd-hybrid-7/ipv4:ircd-hybrid-7/ipv6:g" \
				< ${conf} > ${conf/ipv4/ipv6}
		done
	fi

	# Install the init script and the respective config file.
	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d_ircd ircd
	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d_ircd ircd
}

pkg_postinst() {
	if [ ! -f ${ROOT}/etc/ircd/ircd-ipv4.conf ]
	then
		cp ${ROOT}/etc/ircd/example-ipv4.conf \
			${ROOT}/etc/ircd/ircd-ipv4.conf
	fi
	if use ipv6 && [ ! -f /etc/ircd/example-ipv6.conf ]
	then
		cp ${ROOT}/etc/ircd/example-ipv6.conf \
			${ROOT}/etc/ircd/ircd-ipv6.conf
	fi

	chown -R hybrid:hybrid \
		${ROOT}/etc/ircd ${ROOT}/var/log/ircd ${ROOT}/var/run/ircd
	chmod 700 ${ROOT}/etc/ircd ${ROOT}/var/log/ircd
	find ${D}/etc/ircd -type f -exec chmod 600 {} \;

	einfo "Create /etc/ircd/ircd-{ipv4,ipv6}.conf files and edit"
	einfo "/etc/conf.d/ircd otherwise the daemon(s) will quietly"
	einfo "refuse to run."

	if use ssl
	then
		einfo "To create a rsa keypair for crypted links execute:"
		einfo "emerge --config =${CATEGORY}/${PF}"
	fi
}

pkg_config() {
	local proto="ipv4"
	use ipv6 && proto="${proto} ipv6"

	local i
	for i in ${proto}
	do
		einfo "Generating 2048 bit RSA keypair /etc/ircd/ircd-${i}.rsa"
		einfo "The public key is stored in /etc/ircd/ircd-${i}.pub."

		openssl genrsa -rand ${ROOT}/var/run/random-seed \
			-out ${ROOT}/etc/ircd/ircd-${i}.rsa 2048
		openssl rsa -in ${ROOT}/etc/ircd/ircd-${i}.rsa -pubout \
			-out ${ROOT}/etc/ircd/ircd-${i}.pub
		chown hybrid:hybrid ${ROOT}/etc/ircd/ircd-${i}.rsa ${ROOT}/etc/ircd/ircd-${i}.pub
		chmod 600 ${ROOT}/etc/ircd/ircd-${i}.rsa
		chmod 644 ${ROOT}/etc/ircd/ircd-${i}.pub

		einfo "Update the rsa keypair in /etc/ircd/ircd-${i}.conf and /REHASH."
	done
}
