# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircd-hybrid/ircd-hybrid-7.0.ebuild,v 1.1 2003/12/17 02:37:44 zul Exp $

MAX_NICK_LENGTH=16
MAX_CLIENTS=256
MAX_TOPIC_LENGTH=512
SMALL_NETWORK=1			# true

IUSE="debug ipv6 ssl static zlib"

DESCRIPTION="IRCD-Hybrid - High Performance Internet Relay Chat"
HOMEPAGE="http://ircd-hybrid.com/"
SRC_URI="mirror://sourceforge/ircd-hybrid/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	zlib? ( >=sys-libs/zlib-1.1.4-r1 )
	ssl? ( >=dev-libs/openssl-0.9.6j )
	>=dev-libs/libelf-0.8.2
	>=sys-devel/flex-2.5.4a-r5
	>=sys-devel/bison-1.35
	>=sys-devel/gettext-0.11.5-r1
	>=sys-apps/sed-4.0.7"
RDEPEND=""

pkg_setup()
{
	# Create a dedicated user for running ircd. UID/GID combination was based
	# on some *BSD passwd files.
	if ! groupmod ircd; then
		einfo "Creating ircd group (gid=72)."
		groupadd ircd -g 72 || die "failed to create group: ircd (gid=72)"
	fi
	if ! id ircd; then
		einfo "Creating ircd user (uid=72)."
		useradd -d /usr/share/ircd-hybrid-7 -g ircd -s /bin/false -u 72 ircd \
			|| die "failed to create user: ircd (uid=72)"
	fi

	return 0
}

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Patch Makefile.ins:
	# * Add includedir variable where to install headers.
	# * Remove creation of logdirs under prefix. Use /var/log/ircd instead.
	# * Remove symlinking which won't work in sandbox. Done in src_install().
	# Sed hardcoded CFLAGS to those in make.conf.
	patch -p1 < ${FILESDIR}/${PF}.diff || die "patch failed"
	cp configure configure.dist
	sed -e "s:IRC_CFLAGS=\"-O2 -g \":IRC_CFLAGS=\"${CFLAGS}\":" \
		< configure.dist > configure

	# Store unmodified source tree for compiling necessary shared libs and
	# binaries with ipv6 support.
	if [ -n "$(use ipv6)" ]; then
		mkdir ${T}/ipv6
		cp -r ${S} ${T}/ipv6
	fi
}

src_compile()
{
	local myconf

	ewarn "Server administrators are encouraged to customize some variables in"
	ewarn "the ebuild if actually deploying hybrid in an IRC network."
	ewarn
	ewarn "Maximum nick length       = ${MAX_NICK_LENGTH}"
	ewarn "        topic length      = ${MAX_TOPIC_LENGTH}"
	ewarn "        number of clients = ${MAX_CLIENTS}"
	if [ ${SMALL_NETWORK} ]; then
		ewarn "Configuring for small networks."
		myconf="--enable-small-net"
	fi

	# Wait for admins to see the default variables.
	sleep 5

	use debug || myconf="${myconf} --disable-assert"
	use ssl && myconf="${myconf} --enable-openssl"
	use static && myconf="${myconf} --disable-shared-modules"
	use zlib && myconf="${myconf} --enable-zlib"

	# Set ipv4 defaults to config.h.
	patch include/config.h ${FILESDIR}/config-ipv4.diff \
		|| die "ipv4 defaults patch failed"

	# Set prefix to /usr/share/ircd-hybrid-7 to save some patching.
	./configure \
		--prefix=/usr/share/ircd-hybrid-7 \
		--with-nicklen=${MAX_NICK_LENGTH} \
		--with-topiclen=${MAX_TOPIC_LENGTH} \
		--with-maxclients=${MAX_CLIENTS} ${myconf} || die "ipv4 config failed"
	emake || die "ipv4 make failed"

	# Enable help index.
	cd help
	make index || die "make index failed"
	cd ..

	# Build respond binary for using rsa keys instead of plain text oper 
	# passwords.
	[[ -n "$(use ssl)" ]] && \
		gcc ${CFLAGS} -o respond tools/rsa_respond/respond.c -lcrypto

	# Configure and compile with ipv6 support in temp.
	if [ -n "$(use ipv6)" ]; then
		einfo "IPv6 support"
		cd ${T}/ipv6/${P}

		# Set ipv6 defaults to config.h.
		patch include/config.h ${FILESDIR}/config-ipv6.diff \
			|| die "ipv6 defaults patch failed"

		./configure \
			--prefix=/usr/share/ircd-hybrid-7 \
			--with-nicklen=${MAX_NICK_LENGTH} \
			--with-topiclen=${MAX_TOPIC_LENGTH} \
			--with-maxclients=${MAX_CLIENTS} \
			--enable-ipv6 ${myconf} || die "ipv6 config failed"
		emake || die "ipv6 make failed"
	fi

	# Go back.
	cd ${S}
}

src_install()
{
	# Directories need to exist beforehand or the install will fail.
	dodir /usr/share/man/man8 \
	      /usr/lib/ircd-hybrid-7 \
	      /usr/include/ircd-hybrid-7 \
	      /var/log/ircd \
	      /var/run/ircd \
	      /etc/init.d \
	      /etc/conf.d

	# Override all install directories according to the patches with sandbox
	# prefix. 
	make prefix=${D}/usr/share/ircd-hybrid-7/ \
	     bindir=${D}/usr/sbin/ \
	     sysconfdir=${D}/etc/ircd/ \
	     moduledir=${D}/usr/lib/ircd-hybrid-7/ipv4 \
	     automoduledir=${D}/usr/lib/ircd-hybrid-7/ipv4/autoload/ \
	     messagedir=${D}/usr/share/ircd-hybrid-7/messages/ \
	     includedir=${D}/usr/include/ircd-hybrid-7 \
	     mandir=${D}/usr/share/man/man8/ \
	     install || die "ipv4 install failed"

	# Rename the binary according to config-ipv4.diff.
	mv ${D}/usr/sbin/ircd ${D}/usr/sbin/ircd-ipv4

	# Install the respond binary.
	if [ -n "$(use ssl)" ]; then
		exeinto /usr/sbin
		doexe ${S}/respond
	fi

	# Do the symlinking.
	local link
	local symlinks="topic accept cjoin cmode admin names links away whowas \
	                version kick who invite quit join list nick oper part \
	                time credits motd userhost users whois ison lusers \
	                user help pass error challenge knock ping pong"
	for link in ${symlinks}; do
		dosym ../opers/$link /usr/share/ircd-hybrid-7/help/users/$link
	done
	dosym viconf /usr/sbin/vimotd
	dosym viconf /usr/sbin/viklines

	# Install documentation.
	dodoc BUGS ChangeLog Hybrid-team INSTALL LICENSE README.* RELNOTES TODO
	docinto doc
	dodoc doc/*.txt doc/README.cidr_bans doc/Tao-of-IRC.940110 \
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
	if [ -n "$(use ipv6)" ]; then
		cd ${T}/ipv6/${P}/modules
		make prefix=${D}/usr/share/ircd-hybrid-7/ \
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
	cp ${FILESDIR}/init.d_ircd ${D}/etc/init.d/ircd
	cp ${FILESDIR}/conf.d_ircd ${D}/etc/conf.d/ircd

	# Go back.
	cd ${S}
}

pkg_postinst()
{
	# Create the default config files out of example ones.
	cp /etc/ircd/example-ipv4.conf /etc/ircd/ircd-ipv4.conf
	if [ -n "$(use ipv6)" ]; then
		cp /etc/ircd/example-ipv6.conf /etc/ircd/ircd-ipv6.conf
	fi

	chown -R ircd:ircd /etc/ircd /var/log/ircd /var/run/ircd
	chmod 700 /etc/ircd /var/log/ircd
	find /etc/ircd -type f -exec chmod 600 {} \;

	einfo "Modify /etc/ircd/ircd-{ipv4,ipv6}.conf and /etc/conf.d/ircd"
	einfo "otherwise the daemon(s) will quietly refuse to run."

	if [ -n "$(use ssl)" ]; then
		einfo "To create a rsa keypair for crypted links execute:"
		einfo "ebuild /var/db/pkg/net-irc/${PF}/${PF}.ebuild config"
	fi
}

pkg_config()
{
	local proto="ipv4"
	[[ -x "/usr/sbin/ircd-ipv6" ]] && proto="ipv4 ipv6"

	local i
	for i in ${proto}; do
		einfo "Generating 2048 bit RSA keypair /etc/ircd/ircd-${i}.rsa"
		einfo "The public key is stored in /etc/ircd/ircd-${i}.pub."

		openssl genrsa -rand /var/run/random-seed \
			-out /etc/ircd/ircd-${i}.rsa 2048
		openssl rsa -in /etc/ircd/ircd-${i}.rsa -pubout \
			-out /etc/ircd/ircd-${i}.pub
		chown ircd:ircd /etc/ircd/ircd-${i}.rsa /etc/ircd/ircd-${i}.pub
		chmod 600 /etc/ircd/ircd-${i}.rsa
		chmod 644 /etc/ircd/ircd-${i}.pub

		einfo "Update the rsa keypair in /etc/ircd/ircd-${i}.conf and /REHASH."
	done
}

# vim:ts=4
