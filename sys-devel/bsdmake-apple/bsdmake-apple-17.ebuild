# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION=""
HOMEPAGE=""
MY_PN=${PN%-apple}
SRC_URI="http://opensource.apple.com/tarballs/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# We use BSD's bmake to bootstrap Apple's bsdmake
DEPEND="sys-devel/CoreOSMakefiles 
|| ( virtual/pmake sys-devel/bsdmake-apple )
"
RDEPEND=""

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	[[ ${CHOST} == *-apple-darwin* ]] || epatch ${FILESDIR}/${P}-non-darwin.patch
	epatch "${FILESDIR}"/${P}-bsd-sysctl.patch

	# Though they should be supported, I can't figure out why they are not.
	ebegin Removing all __unused flags.
	grep -rl __unused ${S} | xargs sed -ie 's!__unused!!'
	eend
}

src_compile() {
	# Stolen from toolchain-funcs: 
	# Though this works, some guessing has been involved for the ARCH.
	my_host=${CTARGET:-${CHOST}}
	my_host=${my_host#*-}
	#pmake -I ${S}/mk MACHINE=${my_host%%-*} MACHINE_ARCH=$(tc-arch) \
	#	RC_CFLAGS="${CFLAGS}" MAKEFILEPATH=${EPREFIX}/usr/share/CoreOSMakefiles \
	#	CC=$(tc-getCC) -D NOGCCERROR -D NO_WERROR ${MAKEOPTS} \
	#	|| die "pmake stopped."
	emake BSDMAKE=pmake MACHINE=${my_host%%-*} MACHINE_ARCH=$(tc-arch) \
		RC_CFLAGS="${CFLAGS}" MAKEFILEPATH=${EPREFIX}/usr/share/CoreOSMakefiles \
		CC=$(tc-getCC) NOGCCERROR=1 NO_WERROR=1 ${MAKEOPTS} \
		|| die "pmake stopped."
}

src_install() {
	dodir /usr/bin
	make -d DSTROOT=${D} DESTDIR=${D} \
		BINDIR=${EPREFIX}/usr/bin \
		MAKEFILEPATH=${EPREFIX}/usr/share/CoreOSMakefiles \
		install || die "pmake stopped."
	#mv make bsdmake
	#exeinto /usr/bin
	#doexe bsdmake
}
